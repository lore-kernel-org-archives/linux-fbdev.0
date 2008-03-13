From: Andres Salomon <dilinger@queued.net>
Subject: Re: LCD backlight IOCTL
Date: Thu, 13 Mar 2008 14:05:44 -0400
Message-ID: <20080313140544.187ae2cc@ephemeral>
References: <27AAC353AE72C840926448157F375E7201DD65E1@NAEX17.na.qualcomm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JZrkS-0007eG-DF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 11:01:48 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JZrkQ-0002AI-UE
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 11:01:48 -0700
In-Reply-To: <27AAC353AE72C840926448157F375E7201DD65E1@NAEX17.na.qualcomm.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jrhee@qualcomm.com

On Thu, 13 Mar 2008 09:38:51 -0700
"Rhee, C. Joon" <jrhee@qualcomm.com> wrote:

> Hi, I'm searching for how we can specify the LCD backlight level through
> /dev/fb.
> 
> And for this, should we introduce a new IOCTL?
> 
>  
> 
> FBIOGET/SET_BACKLIGHT
> 
>  
> 
> I looked through CONFIG_FB_BACKLIGHT and bl_dev registration but I found
> this is more of internal usage when there is fb event and I don't really
> see how user app can specify the level.
> 
>  
> 


backlight_device_register() takes a  struct backlight_ops that has
callbacks for getting and setting the backlight.  This ends up
being exported via sysfs, and is a nice way to adjust the backlight.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
