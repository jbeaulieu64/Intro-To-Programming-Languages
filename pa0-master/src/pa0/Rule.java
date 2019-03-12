package pa0;

/**
 * Created by joshuabeaulieu on 9/23/16.
 */
public class Rule {
    private Token lhs = null;
    private TokenStack rhs;

    public Rule(Token lhs, TokenStack rhs) {
        this.lhs = lhs;
        this.rhs = rhs;
    }
    public int match(TokenStack tknStck) {
        int rulePos = 0;
        int tknStckPos = 0;
        int matchCounter = 0;
        boolean matching = false;
        boolean matchFound = false;
        for (; rulePos < getRhsSize(); rulePos++) {
            for (;tknStckPos < tknStck.getSize(); tknStckPos++) {
                if (rhs.peek(rulePos).equals(tknStck.peek(tknStckPos))) {
                    matching = true;
                    matchCounter++;
                    tknStckPos++;
                    break;
                } else if (matching){
                    matching = false;
                    matchCounter = 0;
                    rulePos = -1; // next iteration rulePos = 0
                    break;
                }
            }
            if(matchCounter == getRhsSize()) {
                matchFound = true;
                break;
            }
        }
        return (matchFound ? tknStckPos - matchCounter : -1);
    }

    public int getRhsSize() {
        return this.rhs.getSize();
    }

    public Token getLhs() {
        return lhs;
    }
    public TokenStack getRhs() {
        return rhs;
    }

    @Override
    public String toString() {
        return (this.getLhs().toString() + " = " + this.getRhs().toString());
    }
}
class Token {
    private String value;

    public Token(String token) {
        this.value = token;
    }

    @Override
    public String toString() {
        return this.value;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) { return false; }
        else if (!(obj instanceof Token)) { return false; }
        else if (obj == this) { return true; }

        Token other = (Token) obj;
        return this.toString().equals(other.toString());
    }
}
class TokenStack {

    public static final int DEFAULT_CAPACITY = 5;
    private Token[] tokens = null;
    private int capacity = DEFAULT_CAPACITY;;
    private int pos = 0;
    private int size = 0;

    public TokenStack() {
        this.tokens = new Token[DEFAULT_CAPACITY];
    }

    public TokenStack(String[] tkns) {
        capacity = tkns.length;
        tokens = new Token[tkns.length];

        for (pos = 0; pos < capacity; pos++) {
            tokens[pos] = new Token(tkns[pos]);
        }
        size = tokens.length;
    }

    public void add(Token tkn) {
        if(pos+1 >= capacity) {
            resize();
        } else if (tkn == null) {
            return;
        }
        tokens[pos++] = tkn;
        size++;
    }

    public void remove() {
        if(pos <= 0) {
            return;
        }
        tokens[pos--] = null;
        size--;
    }

    public void remove(int index) {
        if(index < 0 || index > pos || pos <= 0) {
            return;
        }
        for (int i = index; i < pos; i++) {
            tokens[i] = tokens[i+1];
        }
        pos--;
        size--;
    }

    public Token peek(int index) {
        return tokens[index];
    }

    public boolean isEmpty() {
        return (size == 0);
    }

    public int getSize() { return size; }

    @Override
    public String toString() {
        StringBuilder strblder = new StringBuilder();
        for (int i = 0; i < pos; i++) {
            strblder.append((tokens[i] != null ? tokens[i].toString() + " " : ""));
        }

        return strblder.toString().trim();

    }

    private void resize() {
        Token[] newArr = new Token[capacity*2];
        for (int i = 0; i < this.tokens.length; i++) {
            newArr[i] = this.tokens[i];
        }
        this.tokens = newArr;
        capacity *= 2;
    }
}
