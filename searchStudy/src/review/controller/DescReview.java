package review.controller;

import java.util.Comparator;

import review.model.vo.Review;
import review.model.vo.ReviewImage;

public class DescReview implements Comparator {

	@Override
	public int compare(Object o1, Object o2) {
		int result = 0;
		if(o1 instanceof Review && o2 instanceof Review){
			Review r1 = (Review)o1;
			Review r2 = (Review)o2;
			result = r1.getListNo() < r2.getListNo() ? 1 : (r1.getListNo() == r2.getListNo() ? 0 : -1);
		}
		if(o1 instanceof ReviewImage && o2 instanceof ReviewImage){
			ReviewImage r1 = (ReviewImage)o1;
			ReviewImage r2 = (ReviewImage)o2;
			result = r1.getListNo() < r2.getListNo() ? 1 : (r1.getListNo() == r2.getListNo() ? 0 : -1);
		}
		return result;
	}

}
