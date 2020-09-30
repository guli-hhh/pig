package com.sf.cloud.task.task.service;

import com.sf.cloud.task.task.dao.BaseRepository;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
  * @Description
  * @Author tuzhaoliang
  * @Date 2020/7/6 8:28
  **/
@FunctionalInterface
public interface BaseService<T,ID> {

    BaseRepository<T, ID> getRepository();

    default long count() {
        return getRepository().count();
    }

    default T findById(ID id) {
        return getRepository().findById(id).orElse(null);
    }

    default List<T> findAll(){
        return getRepository().findAll();
    }

    default Page<T> findAll(Pageable pageable){
        return getRepository().findAll(pageable);
    }

    default <S extends T> Page<S> findAll(S s, Pageable pageable){
        Example<S> example = Example.of(s);
        return getRepository().findAll(example, pageable);
    }

    default <S extends T> Page<S> findAll(Example<S> s, Pageable pageable){
        return getRepository().findAll(s, pageable);
    }

    default <S extends T> S findOne(Example<S> example){
        return getRepository().findOne(example).orElse(null);
    }

    default T save(T t) {
        return getRepository().save(t);
    }

    default <S extends T> List<S> saveAll(Iterable<S> entities){
        return getRepository().saveAll(entities);
    }

    default boolean deleteById(ID id) {
        try {
            getRepository().deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    default boolean delete(T t) {
        try {
            getRepository().delete(t);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
