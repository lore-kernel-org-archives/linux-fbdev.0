From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 06:28:21 +0800
Message-ID: <42E95C05.7@pol.net>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>	 <42E8F0CD.6070500@gmail.com>	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>	 <9e473391050728092936794718@mail.gmail.com>	 <9e47339105072811183ac0f008@mail.gmail.com>	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>	 <9e4733910507281315419c3c12@mail.gmail.com>	 <9e47339105072813213db7cee4@mail.gmail.com>	 <9e47339105072813507c00687e@mail.gmail.com>	 <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be> <9e47339105072814505b6fe4f8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyGrd-0000SX-FJ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 15:28:29 -0700
Received: from rproxy.gmail.com ([64.233.170.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyGrc-0000vf-Nl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 15:28:29 -0700
Received: by rproxy.gmail.com with SMTP id j1so844538rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 15:28:27 -0700 (PDT)
In-Reply-To: <9e47339105072814505b6fe4f8@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, 28 Jul 2005, Jon Smirl wrote:
>>> I've verified now that all ATI R300+ chips have 10bit cmaps. These are
>>> pretty common so I'd be in favor of making this into a binary
>>> attribute where I can get/set the whole table at once. Given that
>>> OpenGL is already supporting 12 and 16 bits these tables are only
>>> going to get much larger.
>>>
>>> 1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text attribute.
>>>
>>> 65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text attribute.
>>>
>>> The bits_per_pixel sysfs attribute is an easy way to tell how many
>>> entries you need. You can just set it at 4, 8, 10, etc until you get
>>> an error. Now you know the max. 2^n and you know how many entries.
>> No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
>> ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.
> 
> So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
> bits_per_color and then let the driver sort it out.  Otherwise there
> is no way to set ARGB8888 versus ARGB2101010. With bits per color you
> would set 8 or 10.
> 

No, you have to add another attribute for {transp|red|green|blue}.{len,offset}
and another attribute for the pixelformat. Then using those, one can
easily deduce the cmap size.
 
> If that isn't good enough I can switch the attribute to take strings
> like ARGB8888.
> 

Please no.

> What do you think, should I just switch to fbconfig names and a binary
> cmap attribute?
> 

Does a binary attribute not have the same buffer size limitation as
the text attribute?  I really don't know, just asking.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
