From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 18:40:47 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310171836230.966-100000@phoenix.infradead.org>
References: <1066387778.661.226.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAYds-0007Ti-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 10:44:00 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAYdW-0006SK-4x
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 10:43:38 -0700
In-Reply-To: <1066387778.661.226.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Not sure what's up here. The driver is quite passive regarding
> the mode for other VCs, it sort of expect the fbcon layer do pick up
> the default mode and use it for other consoles. I'm not sure what's
> wrong here.

Using ssty or fbset only changes the resolution on the local VC. I did 
this because often with fbset the user sets the mode to something the 
monitor has a hard time with. If this happened to all the VCs then you 
have to type blind to fix all the VCs. So IMO it is better to risk losing 
one VC then all of them. You can change the size of all VCs by calling the 
vt ioctl call VT_RESIZE
 
> In a more general way, I really lack the ability to change the console
> size with fbset like I could do with 2.4. I don't know if James revived
> that feature in his latest patches though. The stty thing isn't very
> reliable imho. Especially on monitors that don't like the standard
> modedb.

Not in this set of patches but with client support coming soon we will be 
able to change the VCs resolution via fbset again.




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
