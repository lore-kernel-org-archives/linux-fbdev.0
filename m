From: Stelios Xanthakis <sxanth@ceid.upatras.gr>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and
 copyarea ioctls
Date: Tue, 14 Jul 2009 12:47:34 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0907131930360.31831@diogenis.ceid.upatras.gr>
References: <20090713151709.GA1297@lilem.mirepesht>
	<20090713084058.547e88f0@infradead.org>
	<20090713162559.GA1279@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sxanth@ceid.upatras.gr>) id 1MQf7z-0004SI-4c
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Jul 2009 10:20:51 +0000
Received: from poseidon.ceid.upatras.gr ([150.140.141.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQf7n-0001cV-UE for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Jul 2009 10:20:46 +0000
In-Reply-To: <20090713162559.GA1279@lilem.mirepesht>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ali Gholami Rudi <ali@rudi.ir>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, Philippe De Muyter <phdm@macqel.be>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Arjan van de Ven <arjan@infradead.org>


On Mon, 13 Jul 2009, Ali Gholami Rudi wrote:

> Arjan van de Ven <arjan@infradead.org> wrote:
>> On Mon, 13 Jul 2009 19:47:09 +0430
>> Ali Gholami Rudi <ali@rudi.ir> wrote:
>>> Is there any reason for not adding these ioctls to fbdev?  I searched
>>> the net and couldn't any.  Anyway, these patches simply implement
>>> those ioctls.
>>>
>>
>> can we turn this around, is there a reason to add them?
>> or in other words, how / where would these be used ?
>
> User-space programs that use framebuffer directly can use them.  I was
> writing a simple framebuffer virtual terminal (using libfreetype for
> fonts; like fbterm); scrolling and painting boxes would be faster if
> there was someway of using hardware accelerated operations.  I think
> other similar programs can benefit, too.
>

hope to see them added too (plus the WAITFORVSYNC ioctl).

The argument seems to be that we're waiting for DRM which will bring
full 3D acceleration to userspace, but imho, besides games you can
have a fully functional gui with the quality of winXP using just
2D acceleration.  (also xvideo is interesting)

DirectFB just duplicates some of the kernel code, but it is always
one step behind and not as well tested.  Since this patch exposes
existing functionality without adding any new untested code, i don't
see a reason why it shouldn't be added.

There are serious use cases of a system that uses just kernel+uclibc+
a full gui just on the framebuffer in a less-than 10MB tarball.


Stelios


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
