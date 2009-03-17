From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: fbdev intel with kernel modesetting
Date: Tue, 17 Mar 2009 07:18:45 -0400
Message-ID: <45a44e480903170418s7dd5cea1n96749a0c441d6a88@mail.gmail.com>
References: <A71FB3B26F3F479BA375A7FA660E5E0F@avitech.sk>
	<21d7e9970903170358x5482218ep695cdffa586fa806@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LjXK0-0002dp-KT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 11:19:00 +0000
Received: from yw-out-1718.google.com ([74.125.46.156])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LjXJm-00061N-W8 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Mar 2009 11:18:55 +0000
Received: by yw-out-1718.google.com with SMTP id 6so882185ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 17 Mar 2009 04:18:45 -0700 (PDT)
In-Reply-To: <21d7e9970903170358x5482218ep695cdffa586fa806@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Mar 17, 2009 at 6:58 AM, Dave Airlie <airlied@gmail.com> wrote:
> On Fri, Feb 27, 2009 at 9:13 PM, Peter Hanzel <hanzelpeter@gmail.com> wrote:
>> Hello.
>>
>> I have a question. I am using intelfb to get framebuffer console on Acer
>> Extensa 5220 notebeook. (VGA Intel 965GM)
>> In kernel 2.6.28.7 i must set video mode on boot with vga= param.
>> Now I have discovered that in 2.6.29 kernel, there is support for kernel
>> modesetting with gpu/drm/i915.
>>
>> Will this be joined with driver/video/intelfb ?
>
> Not joined, hopefully driver/video/intelfb will die.
>
>> So mode switch will work with simple fbdev IOCTL.?
>> Like some cooperation between fbdev and gpu/drm?
>
> The problem with simple ioctl is its simple, it can't express what
> graphics cards actually look like.
>

Hi Dave,

Quick question, longer term, what's your take on fbdev and drm. How
will the two interact (if at all)? Will fbdev be for 2D only devices,
DRM for the GPU enabled devices? and/or will fbdev be deprecated and
everyone including 2D devices use drivers/gpu drivers?

Thanks,
jaya

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
