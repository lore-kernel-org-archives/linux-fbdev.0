From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: How to disable 'rivafb_pan_display START' at boot ?
Date: Mon, 9 Jan 2006 11:23:36 +0100
Message-ID: <20060109102336.GB18282@bogon.ms20.nix>
References: <43C0279A.7060708@paradise.net.nz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvuRh-0000rQ-Kn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 02:40:13 -0800
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EvuRg-0003fb-7o
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 02:40:13 -0800
Content-Disposition: inline
In-Reply-To: <43C0279A.7060708@paradise.net.nz>
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
To: Adam Felix Bogacki <afb@paradise.net.nz>
Cc: ajoshi@unixbox.com, linux-fbdev-devel@lists.sourceforge.net, linux-nvidia@lists.surfsouth.com, debian-powerpc@lists.debian.org

On Sun, Jan 08, 2006 at 09:42:02AM +1300, Adam Felix Bogacki wrote:
> [xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
> [xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
> [xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
> [xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
> [xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
> [xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
> [xxx.xxxxxx] rivafb_pan_display START   [xxx.xxxxxx] rivafb_pan_display START
> [xxx.xxxxxx] rivafb_pan_display END     [xxx.xxxxxx] rivafb_pan_display END
Disable CONFIG_RIVAFB_DEBUG in you kernel configuration and rebuild.
 -- Guido



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
