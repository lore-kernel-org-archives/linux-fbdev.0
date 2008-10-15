From: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
Date: Wed, 15 Oct 2008 16:27:23 +0200
Message-ID: <48F5FDCB.2090808@selcomgroup.com>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
	<48F5F2BF.2040805@selcomgroup.com> <48F5FC55.4000708@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <48F5FC55.4000708@denx.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net

Ok I understand.

FWIW, based on my trials:

    * DirectFB support on BE hosts is somehow easier than with
      carminefb: the patches from Nikita Egorov are working almost out
      of the box (they basically change every single access to memory so
      that it becomes ABGR, so that a simple memcpy to/from Carmine
      memory is already the right alignment. I don't know if it would be
      working without these patches on kernel >2.6.26 (with
      FOREIGN_ENDIAN defines) since I'm currently stuck to a vanilla
      2.6.24.6
    * However, DirectFB has some troubles with panning, which is working
      using a different approach by myself: I'll check it and see if
      it's worth posting here.
    * 800x600 resolution is supported if I try 800x600-24@60  before
      trying 640x480-16@60

Thank you,
M

Anatolij Gustschin ha scritto:
> Matteo Fortini wrote:
>
>   
>> What about the mb86290 framebuffer driver directly from Fujitsu which is
>> in the mainline kernel?
>>     
>
> This mb86290 framebuffer driver from Fujitsu isn't in mainline, it
> is in the DENX Linux Kernel tree.
>
>   
>> It's from 2003 and supports only until 86293, but can it be used as a
>> basis for a proper fb driver? It has a lot of features indeed...
>>     
>
> I think it won't be accepted in mainline. It was developed for 2.4
> Kernel and slightly modified for 2.6. These features could be added
> to the new driver which is intended to provide initial support for
> Fujitsu GDCs in mainline now.
>
> Anatolij
>
>   
