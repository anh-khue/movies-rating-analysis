package io.anhkhue.akphim.mining.recommendations;

import java.util.Map;

public interface MovieRecommendation<A, F> extends Recommendation {

    Map<Integer, Double> recommend(A anchor, F miningFunction);
}
