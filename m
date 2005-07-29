From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Fw: framebuffer blitting performance loss
 2.6.12 -> 2.6.13-rc3
Date: Sat, 30 Jul 2005 06:45:11 +0800
Message-ID: <42EAB177.6070808@gmail.com>
References: <20050715033912.1cd9b6c3.akpm@osdl.org>	 <200507221158.23454.adaplas@gmail.com>	 <20050729001735.5934622f.akpm@osdl.org> <42EA430C.2010405@t-online.de>	 <42EA4E6A.70907@gmail.com>	 <Pine.LNX.4.56.0507292041110.17988@pentafluge.infradead.org> <9e4733910507291321609b4c48@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DydbS-0007Bq-CG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:45:18 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DydbS-0003Vy-8N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 29 Jul 2005 15:45:18 -0700
Received: by wproxy.gmail.com with SMTP id i20so662180wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Jul 2005 15:45:11 -0700 (PDT)
In-Reply-To: <9e4733910507291321609b4c48@mail.gmail.com>
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
Cc: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>

Jon Smirl wrote:
> On 7/29/05, James Simmons <jsimmons@infradead.org> wrote:
>>> Thank you for your persistence.  I think I know the culprit.  Someone
>>> insisted on using memcpy in fb_pad_aligned_buffer().  I have already
>>> fixed this before, but apparently, the memcpy was brought back.  Try
>>> the attached patch and let me know.
>> Yipes, I did that. The memcpy function is suppose to be optimized for the
>> platform. See string.h in the include/asm directory. I seen for example
>> the Athlon would use the 3DNow instruction set to copy data. Something
>> is really wrong with memcpy if moving byte by byte is faster !!!!
>> Alot of drivers use memcpy. If memcpy sucks then drivers should be copying
>> byte by byte then. The question I have is this the case for non intel
>> platforms as well. Could someone run the numbers on other platforms?
> 
> memmove/memcpy is faster. memcpy is faster than memmove so use it if
> you can. But, there is a lower limit probably around 16 bytes or so
> where the loop becomes faster.  So if you know that you will always be
> copying small fragments use the loop.  The compiler can't decide

Yes, the loop copies each row of a font character.  For an 8x16 font
that's 1 byte. The maximum fontwidth is 32. A 12x22 font does not pass
through this function because the width is not a multiple of 8.  So,
currently, it's used mostly for 8x16 fonts. 

I already know people using 16x30 fonts. There are probably others bigger
than that. 

Of course, we can always use Duff's version to loop-unroll that particular
section, but even at 4 bytes, I don't know if it's worth the effort. Anyone
knows people using 32 wide fonts?

Tony



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
