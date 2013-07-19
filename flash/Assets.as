package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="../media/playerBase.png")]
		public static const Player:Class;
		
		[Embed(source="../media/enemyBase.png")]
		public static const Enemy:Class;
		
		[Embed(source="../media/bgLayer1.png")]
		public static const BgLayer1:Class;
		
		[Embed(source="../media/bgLayer2.png")]
		public static const BgLayer2:Class;
		
		[Embed(source="../media/WelcomeBackground.png")]
		public static const WelcomeBackground:Class;
		
		[Embed(source="../media/LifeStar.png")]
		public static const LifeStar:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../media/mySprites.png")]
		public static const AtlasTextureGame:Class;
	
		[Embed(source="../media/mySprites.xml",mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
//		[Embed(source="../media/score.fnt", mimeType="application/octet-stream")]
//		public static const FontXml:Class;
//		
//		[Embed(source = "../media/score_0.png")]
//		public static const FontTexture:Class;
		
		public static function getAtlas():TextureAtlas{
			if(gameTextureAtlas == null){
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture,xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
	}
}