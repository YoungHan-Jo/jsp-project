package com.example.util;

import java.lang.reflect.Type;

import com.example.domain.RecommendVO;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;

public class RecommendDeserializer implements JsonDeserializer<RecommendVO> {

	@Override
	public RecommendVO deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
			throws JsonParseException {
		
		RecommendVO recVO = null;
		
		if(json.isJsonObject()) {
			JsonObject jsonObject = json.getAsJsonObject();
			
			recVO = new RecommendVO();
			recVO.setBoardNum(jsonObject.get("boardNum").getAsInt());
			recVO.setId(jsonObject.get("id").getAsString());
			
		}
		
		return recVO;
	}

	
}
