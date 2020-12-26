package com.eds.eds.redis;

public interface MessagePublisher {

    void publish(final String message);
}