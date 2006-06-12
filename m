From: syed khader <sk.syed@yahoo.com>
Subject: porting fb driver to 2, 6(fb_get_fix,
	fb_get_var)
Date: Mon, 12 Jun 2006 05:26:24 -0700 (PDT)
Message-ID: <20060612122624.70277.qmail@web37915.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FplV1-0005T0-6t for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:26:31 -0700
Received: from web37915.mail.mud.yahoo.com ([209.191.124.110])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FplV0-0007ky-Rm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:26:31 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,
  I am trying to port one of our LCD display frame
buffer driver to 2.6 kernel.
  The old 2.4 kernel had these functions defined in
fb_ops
    fb_open:    
    fb_release:
    fb_get_fix: 
    fb_get_var:     
    fb_set_var: 
    fb_get_cmap:
    fb_set_cmap: 
    fb_ioctl:   

  But the latest 2.6 fb_ops has removed these and
there is entirely new set of functions. 
  I tried to go to list archives but I could not find
information. 
  What functions in 2.6 fb_ops should to used to
implement this old 2.4 set of functions?

Regards
Syed






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
