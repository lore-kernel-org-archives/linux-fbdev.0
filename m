From: Otto Solares <solca@guug.org>
Subject: Re: Changing modes with fbset
Date: Mon, 5 Jan 2004 18:28:22 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040106002822.GB442@guug.org>
References: <3FDBB97F.4070207@undead.cc> <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adf5m-0006dQ-9A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:29:06 -0800
Received: from [168.234.203.30] (helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Adf5l-0005ha-Gw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 16:29:05 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Jan 06, 2004 at 12:06:04AM +0000, James Simmons wrote:
> 
> Applied. Thanks for finding that.

Hi James! now that you are back again, i would like to suggest
a modification to fbdev core, i am having problems guessing
which card is attached to a fb device.  I need this info to
solve the 'more than 1 card' situation.  This could be easily
fixed if the fbdev api provides the busid of the card, like
"pci:0000:01:0.0".  That would solve a lot of things in the
HAL detection routines.  Maybe that could be exported via
sysfs but i have been waiting for sysfs for a while and don't
see it coming to a reality.  Maybe an ioctl is enough.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
