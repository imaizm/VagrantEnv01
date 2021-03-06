var express = require('express');
var router = express.Router();

var Photo = require('../models/Photo');
var path  = require('path');
var fs    = require('fs');
var join  = path.join;
var formidable = require('formidable');

/*
app.get( '/',                   photos.list);
app.get( '/upload',             photos.form);
app.post('/upload',             photos.submit(app.get('photos')));
app.get( '/photo/:id/download', photos.download(app.get('photos')));
*/
module.exports = function(dir) {

	/*
	exports.list = function(req, res) {
		res.render('photos', {
			title: 'Photos',
			photos: photos
		});
	};
	*/

	/*
	router.get('/photos', function(req, res) {
		res.render('photos', {
			title: 'Photos',
			photos: photos
		});
	});
	*/

	/*
	exports.list = function(req, res, next) {
		Photo.find({}, function(err, photos) {
			if (err) return next(err);
			res.render('photos', {
				title: 'Photos',
				photos: photos
			});
		});
	};
	*/

	router.get('/', function(req, res, next) {
		Photo.find({}, function(err, photos) {
			if (err) return next(err);
			res.render('photos', {
				title: 'Photos',
				photos: photos
			});
		});
	});

	/*
	exports.form = function(req, res) {
		res.render('photos/upload', {
			title: 'Photo upload'
		});
	};
	*/

	router.get('/upload', function(req, res) {
		res.render('photos/upload', {
			title: 'Photo upload'
		});
	});

	/*
	exports.submit = function (dir) {
		return function(req, res, next) {
			var img  = req.files.photo.image;
			var name = req.body.photo.name || img.name;
			var path = join(dir, img.name);

			fs.rename(img.path, path, function(err) {
				if (err) return next(err);

				Photo.create({
					name: name,
					path: img.name
				}, function(err) {
					if (err) return next(err);
					res.redirect('/');
				});
			});
		};
	};
	*/

	router.post('/upload', function(req, res, next) {
		var form = formidable.IncomingForm();

		form.parse(req, function (err, fields, files) {
			var img  = files.photo_image;
			var name = fields.photo_name || img.name;
			var path = join(dir, img.name);

			fs.rename(img.path, path, function(err) {
				if (err) return next(err);

				Photo.create({
					name: name,
					path: img.name
				}, function(err) {
					if (err) return next(err);
					res.redirect('/');
				});
			});
		});
	});

	/*
	exports.download = function(dir) {
		return function(req, res, next) {
			var id = req.params.id;
			Photo.findById(id, function(err, photo) {
				if (err) return next(err);
				var path = join(dir, photo.path);
				res.download(path, photo.name+'.jpeg');
			});
		};
	};
	*/

	router.get('/:id/download', function(req, res, next) {
		var id = req.params.id;

		Photo.findById(id, function(err, photo) {
			if (err) return next(err);
			var path = join(dir, photo.path);
			res.download(path, photo.name+'.jpg');
		});
	});

	return router;
};
