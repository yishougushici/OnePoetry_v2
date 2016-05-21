package gushici.action.game;

import java.util.HashMap;
import java.util.Stack;

/**
 * Created by Jason Song(wolfogre.com) on 2016/5/21.
 */
public class RoundDialogue {
	private Stack<String> contentStack;
	private Stack<Boolean> isMineStack;

	public RoundDialogue(){
		contentStack = new Stack<>();
		isMineStack = new Stack<>();
	}

	public void add(String content, Boolean isMine){
		contentStack.push(content);
		isMineStack.push(isMine);
	}

	public boolean isMyTurn(){
		return !isMineStack.peek();
	}

	public char getLastCharacter(){
		return contentStack.peek().charAt(contentStack.peek().length() - 1);
	}

}
