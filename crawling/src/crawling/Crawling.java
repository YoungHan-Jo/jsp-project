package crawling;

import java.io.IOException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Crawling {

	public static void main(String[] args) {

		String url = "http://www.cgv.co.kr/movies/"; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-movie-chart");

		System.out.println("============================================================");

		Elements elements = element.select("li");

		int num = 1;

		for (Element li : elements) {
			if (li.text().length() > 0) { // 내용이 있는 li만 가져오기
				
				int rank = num;
				String title = li.select("strong.title").text().trim();
				String reserveRate = li.select("strong.percent span").text().trim();
				String releaseDate = li.select("span.txt-info").text().trim().substring(0, 10);
				String imgUrl = li.select("span.thumb-image img").attr("src");

				System.out.println(rank + "\t" + title + "\t" + reserveRate + "\t" + releaseDate + "\t" + imgUrl);

				num++;
			} // if
		} // for

		System.out.println("============================================================");

	}// main
}
