From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/6] fbcon: Stop framebuffer
	operations before hardware is properly initialized
Date: Mon, 14 Mar 2005 10:07:15 +1100
Message-ID: <1110755235.5787.189.camel@gaston>
References: <200503130833.44469.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAcBu-00022n-U6
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:08:10 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAcBt-00072q-De
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:08:10 -0800
In-Reply-To: <200503130833.44469.adaplas@hotpop.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Sun, 2005-03-13 at 08:33 +0800, Antonino A. Daplas wrote:
>   Accessing the hardware before it is properly initialized can lead to crashes
>   or screen corruption.  This happens when switching to X then back to console.
>   When console comes back from X, the device is in an undefined state. During
>   this window, accessing the hardware is disallowed.
> 
>   A new field in fbcon_par is added (graphics), which will be set to nonzero
>   just before initialization of the framebuffer and when coming back from
>   KD_GRAPHICS, then unset when an fb_set_var/fb_set_par is done.  While this
>   field is set, no accesses to the hardware is done. The consequence of
>   this change is, hopefully, more robust switching between KD_GRAPHICS<->
>   KD_TEXT.
> 
>   An added benefit coming from this change is that the MODESWITCHLATE hack
>   is not needed anymore and thus removed.  This hack is used by savagefb,
>   rivafb and nvidiafb.

Excellent ! That should fix some nasty issues I've been dealing with as
well !

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
