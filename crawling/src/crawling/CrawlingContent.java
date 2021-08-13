package crawling;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class CrawlingContent {

	public String crawlingContent(String movieNum) {
		String content = "";

		String url = "http://www.cgv.co.kr/movies/detail-view/?midx=" + movieNum; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-story-movie");
		
		content = element.text();

		return content;
	}
}
