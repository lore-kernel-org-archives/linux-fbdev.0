From: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] add modeline for 1680x1050@60
Date: Tue, 14 Mar 2006 11:17:06 +0100
Message-ID: <20060314101706.GA15227@suse.de>
References: <20060313123502.GA5996@suse.de> <4415DB74.5040203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJ6aV-0002iR-On
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 02:17:11 -0800
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FJ6aU-0006De-8g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 02:17:11 -0800
Content-Disposition: inline
In-Reply-To: <4415DB74.5040203@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

 On Tue, Mar 14, Antonino A. Daplas wrote:

> Olaf Hering wrote:
> > Add a modeline for the Philips 200W display. 
> > aty128fb does not do DDC, it picks 1920x1440 or similar.
> > It works ok with nvidiafb because it can ask for DDC data.
> 
> What happens if you use something like
> 
> video=atyfb:1680x1050M@60; or
> video=atyfb:1680x1050MR@60

It still switches to 1900x1200@60


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
