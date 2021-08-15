package crawling;

import java.io.IOException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class CrawlingNewMovie {

	public static void main(String[] args) {

		String url = "http://www.cgv.co.kr/movies/pre-movies.aspx"; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-movie-chart");

		Element ol = element.select("ol").first();
		Elements lists = ol.select("li");
		
		System.out.println("============================================================");
		
		int num = 1;
		
		for(Element li : lists) {
			int newRank = num;
			String title = li.select("strong.title").text().trim();
			String imgUrl = li.select("span.thumb-image img").attr("src");
			String movieNum = imgUrl.substring(imgUrl.lastIndexOf("/")+1, imgUrl.lastIndexOf("/")+6);
			String reserveRate = li.select("strong.percent span").text().trim();
			String releaseDate = li.select("span.txt-info").text().trim().substring(0, 10);
			String dDay = li.select("em.dday").text().trim();
			
			System.out.println(newRank + "\t" +movieNum + "\t" + dDay + "\t" + title + "\t" + reserveRate + "\t" + releaseDate + "\t" + imgUrl);
			
			
			num++;
		}
		
		System.out.println("============================================================");

	}// main
}
