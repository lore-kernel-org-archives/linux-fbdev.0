From: "Wu Yu" <vestige.lug@gmail.com>
Subject: About framebuffer and overlay
Date: Mon, 17 Mar 2008 23:45:10 +0800
Message-ID: <4c7882780803170845p1b3a9879id30cc315e7d3c41e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbHWT-0006Eu-Mk for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 08:45:14 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JbHWS-0005oS-CR
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 08:45:13 -0700
Received: by wa-out-1112.google.com with SMTP id k22so6453438waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 17 Mar 2008 08:45:11 -0700 (PDT)
Content-Disposition: inline
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

Hi all,
    I've just got in to develop framebuffer programs, and I've read
though the Framebuffer-HOWTO, but it doesn't seem to help a lot.
    I wanna know if framebuffer is the abstraction of the graphic
device, what about the overlay? What's the relationship between
framebuffer and overlay?
   I've already enable frambuffer on my laptop, and the color-depth is
32-bit, which is BGRA. But is it possible to display YUV image on the
framebuffer directly without changing it to BGR?

  Thanks a lot!

-- 
Wu Yu

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
