From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: A strange question for LCD
Date: Tue, 5 Oct 2004 11:07:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410051107.58899.adaplas@hotpop.com>
References: <BAY17-F22jQHtMFauky00016eb2@hotmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEfgQ-0005QU-2w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 20:08:10 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEfgJ-0004zN-S6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 20:08:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3E1918B4200
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  5 Oct 2004 03:07:56 +0000 (UTC)
In-Reply-To: <BAY17-F22jQHtMFauky00016eb2@hotmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, z g <zgrong188@hotmail.com>

On Monday 04 October 2004 23:15, z g wrote:
> I have a LCD(LQ035q7db02). It supports 240X320(H X W). I have a frame
> buffer driver for it and it works well. But I have to change the display
> mode in 320X240 (H X W) . I don't know whether I can change the frame
> buffer driver to implement it. If can, how to change the driver. If anyone
> can help me? Thanks!

You need to support 2 methods:

xxxfb_check_var()
- check the passed var structure for compatibility with the hardware. If
not, it's acceptable to return a modified var that is agreeable to the
driver. 

xxxfb_set_par()
- change the hardware state according to the contents of info->var.

Once you've added the above methods, you can choose the driver's initial
mode by various methods, or you can use fbset to change the resolution after
the driver loads.

Tony 




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
