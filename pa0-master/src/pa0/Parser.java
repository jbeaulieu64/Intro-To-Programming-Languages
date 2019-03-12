package pa0;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created by Joshua Beaulieu on 9/23/16.
 */
public class Parser {
    private ArrayList<Rule> rules;
    private TokenStack tokens;
    private Token startToken;

    public Parser() {
        this.rules = new ArrayList<>();
        this.tokens = new TokenStack();
    }

    private void createRules(ArrayList<String> strRules) {
        String lastLHS = strRules.get(0).split("=")[0].trim(); // gets the last nonTerminal for the case of the |
        boolean startTokenFound = true;
        for (String str : strRules) {
            if(str.contains("|")) {
                str = str.replace("|", lastLHS + " = ");
            } else {
                lastLHS = str.split("=")[0].trim();
            }

            String[] tkns = str.split("=");
            this.rules.add(new Rule(new Token(tkns[0].trim()), new TokenStack(tkns[1].trim().split(" "))));

            if(startTokenFound) {
                this.startToken = new Token(tkns[0].trim());
                startTokenFound = false;
            }
        }
    }

    private boolean parse(String[] testTkns) {
        int pos = 0;
        int ruleCounter = 0;
        do {
            // shift
            tokens.add(new Token(testTkns[pos++]));

            // reduce
            while(ruleCounter != this.rules.size()) {
                ruleCounter = reduce();
                if (ruleCounter == this.rules.size()) {
                    ruleCounter = reduce();
                }
            }
            ruleCounter = 0;
            System.out.println(tokens + " | " + tokens.getSize());
        } while(pos < testTkns.length);

        return (tokens.getSize() == 1 && tokens.peek(0).equals(startToken));
    }

    private int reduce() {
        int ruleCounter = 0;

        for (Rule rule : this.rules) {
            int matchStartIndex = rule.match(this.tokens);
            int matchEndIndex = matchStartIndex + rule.getRhsSize();

            if (matchStartIndex < 0) {} //no match = do nothing
            else if (matchEndIndex - matchStartIndex == rule.getRhsSize()) {
                for (int i = matchStartIndex; i < matchEndIndex; i++) {
                    tokens.remove();
                }
                tokens.add(rule.getLhs());
                break;
            } else {} // incomplete match
            /* //debug code
            System.out.println("Rule: " + rule);
            System.out.println("Token Stack: " + tokens);
            System.out.println("--------------");*/
            ruleCounter++;
        }

        return ruleCounter;
    }

    public static void main(String[] args) {

        Scanner grammarScan = null;
        Scanner strScan = null;
        try {
            grammarScan = new Scanner(new File(args[0]));
            strScan = new Scanner(new File(args[1]));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        grammarScan.useDelimiter(System.lineSeparator());
        strScan.useDelimiter(System.lineSeparator());

        Parser parser = new Parser();
        ArrayList<String> strRules = new ArrayList<>();

        //get rules
        while (grammarScan.hasNext()) {
            strRules.add(grammarScan.next());
        }

        //get string to validate
        String str = strScan.next();

        parser.createRules(strRules);
        boolean valid = parser.parse(str.trim().split(" "));
        System.out.println((valid ? "String is valid!" : "String is invalid!"));

    }
}
