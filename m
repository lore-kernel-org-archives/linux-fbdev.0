From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Default video mode
Date: Tue, 13 Dec 2005 08:30:36 +0800
Message-ID: <439E162C.1090707@gmail.com>
References: <439DB6E6.4010601@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ely44-0004SQ-12
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:30:44 -0800
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ely42-0000o7-N4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Dec 2005 16:30:44 -0800
Received: by zproxy.gmail.com with SMTP id x3so1553488nzd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 Dec 2005 16:30:41 -0800 (PST)
In-Reply-To: <439DB6E6.4010601@t-online.de>
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
To: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Is there any regularly used software that would have problems with
> a virtual x/y resolution unequal to the displayed x/y resolution for the
> initial, default video mode of a framebuffer driver?

None that I know of.  A few drivers maximize yres_virtual at load:
tdfxfb, savagefb, nvidiafb, i810fb, rivafb, even vesafb, and others.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
