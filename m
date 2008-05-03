From: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Subject: Re: [PATCH V7] [FB] Add the carmine FB driver.
Date: Sat, 3 May 2008 08:01:27 +0200
Message-ID: <20080503060127.GA30328@Chamillionaire.breakpoint.cc>
References: <20080502172754.GA18973@Chamillionaire.breakpoint.cc>
	<20080502162114.b6a5e617.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JsAoR-0000ze-EG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 23:01:35 -0700
Received: from chamillionaire.breakpoint.cc ([85.10.199.196]
	ident=G2wL6ZuayTZo\z0haXx|IP)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JsAoP-0006V6-VV
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 May 2008 23:01:35 -0700
Content-Disposition: inline
In-Reply-To: <20080502162114.b6a5e617.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@linutronix.de, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

* Andrew Morton | 2008-05-02 16:21:14 [-0700]:

>On Fri, 2 May 2008 19:27:54 +0200
>Sebastian Siewior <frame+buffer@ml.breakpoint.cc> wrote:
>
>> +static const struct fb_videomode carmine_modedb[] = {
>> +	{
>> +		.name		= "640x480",
>> +		.xres		= 640,
>> +		.yres		= 480,
>> +		.pixclock	= 0,
>> +		.left_margin	= 0,
>> +		.right_margin	= 0,
>> +		.upper_margin	= 0,
>> +		.lower_margin	= 0,
>> +		.hsync_len	= 0,
>> +		.vsync_len	= 0,
>> +		.sync		= 0,
>> +		.vmode		= 0,
>> +		.flag		= 0,
>> +	}, {
>> +		.name		= "800x600",
>> +		.xres		= 800,
>> +		.yres		= 600,
>> +		.pixclock	= 0,
>> +	},
>> +};
>
>The initialisations with zero here aren't needed - the compiler does it. 
>Normally we omit them, but sometimes they can be nice for commentary
>reasons.  A minor thing.
Removed

Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
