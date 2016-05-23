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

	public void clear(){
		contentStack.clear();
		isMineStack.clear();
	}

	public boolean isMyTurn(){
		return isMineStack.empty() || !isMineStack.peek();
	}

	public char getLastCharacter(){
		return contentStack.peek().charAt(contentStack.peek().length() - 1);
	}

	public boolean isUsed(String content){
		for(int index = 0; index < contentStack.size(); ++index){
			if(contentStack.get(index).equals(content) && isMineStack.get(index))
				return true;
		}
		return false;
	}

	public boolean empty(){
		return contentStack.isEmpty();
	}
}
