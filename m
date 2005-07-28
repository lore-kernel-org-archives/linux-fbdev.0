From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 07:19:48 +0800
Message-ID: <42E96814.8030005@pol.net>
References: <200507280031.j6S0V3L3016861@hera.kernel.org> <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> <9e473391050728060741040424@mail.gmail.com> <42E8F0CD.6070500@gmail.com> <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyHfX-0002oQ-6r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 16:20:03 -0700
Received: from rproxy.gmail.com ([64.233.170.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyHfW-0002Nu-P8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 16:20:03 -0700
Received: by rproxy.gmail.com with SMTP id a41so875775rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 16:19:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Geert Uytterhoeven wrote:
> On Thu, 28 Jul 2005, Antonino A. Daplas wrote:
>> Jon Smirl wrote:
>>> On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:
>>> There are a couple of ways to fix this. 
>>> 1) Add a check to limit use of the sysfs attributes to 256 entries. If
>>> you want more you have to use /dev/fb0 and the ioctl. More is an
>>> uncommon case.
>>> 2) Switch this to a binary parameter. Now you have to use tools like
>>> hexdump instead of cat to work with the data. It was nice to be able
>>> to use cat to see the current map.
>>>
>>> Does anyone have preferences for which way to fix it?
>> Or...
>>
>>  3) Add another file in sysfs which specifies at what index and how many
>> entries will be read or written from or to the cmap. With this additional
>> sysfs file, it should be able to handle any reasonable cmap length, but
>> it will take more than one reading of the color_map file. Another
>> advantage is that the entire color map need not be read or written if
>> only one field needs to be changed.
>>
>> I've attached a test patch.  Let me know what you think.
> 
> I like it! ... But, a disadvantages is that it needs to store state between two
> non-atomic operations. E.g. imagine two processes doing this at the same time.

We can add a check that if the incoming buffer index start and length does
not match the current start and len (as set by cmap_range), then exit with
and empty buffer.

Conversely, users  can always check if the output read from color_map matches
the value it entered in cmap_range.

As a side note:

The rest of the fbsysfs attributes suffer from the same thing, especially since the
value of each attribute depends on each other.  What if one process reads the
virtual_size, while another one changes the bits_per_pixel?  I'm pretty sure that
setting bits_per_pixel to a higher value will almost always change the virtual_size.

Currently, the only way to guarantee atomicity is to use the ioctls. The main
reason why we change the video mode, framebuffer format, color format, etc in one
go with fb_set_var() is precisely this.

Tony


 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
