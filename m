From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Devices don't get linked to their class.
Date: Sat, 4 Sep 2004 20:41:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409042041.55199.adaplas@hotpop.com>
References: <1094187751.2979.41.camel@laptop.cunninghams>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3Zrr-0004X1-2D
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 05:42:07 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3Zrp-0006dT-L2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 05:42:06 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 52F9772630
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Sep 2004 12:41:54 +0000 (UTC)
In-Reply-To: <1094187751.2979.41.camel@laptop.cunninghams>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Nigel Cunningham <ncunningham@linuxmail.org>

On Friday 03 September 2004 13:02, Nigel Cunningham wrote:
> This morning I began work on addressing the problem. I thought the best
> approach would be to use device classes to find the struct dev for the
> frame buffer driver, and then use the same code I use for storage
> devices to avoid suspending the frame buffer until later. I successfully
> wrote a helper to find the 'graphics' class that fbmem.c creates, but
> now I've run into a more serious issue. register_framebuffer (in the
> same time) calls class_simple_device_add with a NULL for the pointer to
> the struct device. Is it possible for this issue to be addressed? I can

I guess it's doable, but will require small changes to all framebuffer 
drivers.  All you need is struct device, right?  Maybe I can brew up a test 
patch next week.

> see that (at least in the Radeon case) one could simply call
> register_framebuffer with an additional parameter, but thought I'd email
> you and seek your wisdom.
>
> By the way, am I missing something? It looks like framebuffer_alloc does
> nothing with the dev parameter passed to it.

For now, yes.  Maybe in the future, when full-pledged sysfs support is 
added...

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
