From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH]: rivafb DDC2/I2C
Date: Mon, 12 Jan 2004 23:24:52 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401122312550.5232-100000@phoenix.infradead.org>
References: <1073947811.763.175.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgBQY-0006Y6-5M
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 15:24:58 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AgBQX-0000Qf-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 15:24:57 -0800
In-Reply-To: <1073947811.763.175.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> James: Are you still around ? Got my previous set of patches ?

Yes. I applied your pixmap locking fix. Its in the BK tree. This weekend I 
setup most of my machines. I have my sparc/ix86 and indy running and 
ready for testing :-) I also pulled out my few dozen video cards. 

> I think it's time to start feeding Andrew (though I'd rather
> add the FB_ACTIVATE_FIND first, but that can always get in later
> if we really want it).
> 
> Note that I reproduced cases of console resize via stty blowing
> up in accel_clear_margins on an x86, I think that's unrelated to
> the changes I did though, but I haven't figured out what's going
> on exactly yet. It blows up after the resize, apparently in a
> call to fbcon_switch()...

Strange. Is this a specific driver issue or in general. I think it should 
be okay otherwise. Will test in the next few days a few different cards.



> 
> Ben.
> 
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
