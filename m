From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: make pan and copyarea() play nice
Date: Fri, 04 Jun 2004 14:12:00 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1086322320.1876.64.camel@gaston>
References: <20040604022838.GB4175@havoc.gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW63V-0000qe-9N
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 21:11:45 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BW63U-0000Dd-Sk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 21:11:45 -0700
In-Reply-To: <20040604022838.GB4175@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-06-04 at 12:28, David Eger wrote:
> Dear Ben,
> 
> Please apply this to radeon with the previous fb accel capabilities patch
> I sent you.  This patch solves a couple of screen garbage issues I saw when 
> trying to use both panning and copyarea()/fillrect().   
> 
> For some reason, I've got to sync() the engine after each copyarea()/
> fillrect() call.  I don't know why this should be, but when I do, the
> corruption goes away...

Hrm... that isn't normal. Have you dbl checked that the fifo space
required by all other operations is correct ? Tried increasing it a bit
? One possibility is something tapping video memory without requesting a
sync first ... maybe the cursor code still has some breakage there...

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
