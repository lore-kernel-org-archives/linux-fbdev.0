From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ATI X600 on 2.6.15
Date: Thu, 05 Jan 2006 20:56:53 +1100
Message-ID: <1136455013.4840.73.camel@localhost.localdomain>
References: <20060105014229.GB10726@localhost>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuRqp-0007KH-Vo
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 01:56:07 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EuRqo-00053F-3A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 01:56:08 -0800
In-Reply-To: <20060105014229.GB10726@localhost>
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
Cc: bob.picco@hp.com

On Wed, 2006-01-04 at 20:42 -0500, Bob Picco wrote:
> I have machine lockups on 2.6.15 with gentoo bits and lastest x11-org
> bits. A simple startx with three xterms doesn't even render the fonts
> correctly.  Eventually the machine wedges and can't be pinged.
> Switching the xorg.conf driver from radeon to vesa works and creates a
> reasonable environment. This seems to have manifested itself since
> 2.6.15-rc1.
> 
> The laptop is a Compaq NX9600 with maximum memory and a large disk.
> 
> Should anyone care for further data captured from /proc, config, logs
> and etc., I'll be glad to forward them along.  I'd also be willing to
> debug and/or test whatever suggestions might be made.

Is DRI enabled ? If yes, try disabling it. Recent kernels have the r300
enable DRM, thus X will automatically enable use of CCE acceleration
even for simple 2D, but that isn't very stable on those cards yet.

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
