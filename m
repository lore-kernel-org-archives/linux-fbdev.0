From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Tile Blitting
Date: Wed, 26 Feb 2003 20:11:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302261933310.12126-100000@phoenix.infradead.org>
References: <1045998239.1188.4.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18o7ui-0000yI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 12:12:25 -0800
In-Reply-To: <1045998239.1188.4.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Boy this has been tricky to handle. I have been thinking about how to 
handle image blitting from normal memory to texture mappings to tiles.
Then after that I have to make it abstract to fit all these models. 
Pretty much I have come to the conclusion that we have two models.

Model 1: Consistent mappings. 

	In this model we allocate one time a buffer to store image data.
	The fbcon classic is loadfont. It could also be creating texures
	and saving it in a permentant texture map buffer that is present 
        on the card. Same for tiles. We create a bunch of tiles and save 
        them somewhere. We then use a index of some kind later to draw 
	the image.

Model 2: Streaming mappings. 

	This model has us create a temporary memory pool to store data 
	then draw it. After drawing is complete we release the memory. 
	

As you can see the standard imageblit function falls into model 2. At 
present we allocate a static buffer :-( Now for a PCI DMA based card we 
want a hook to allocate a chunck of memory via pci_alloc_consittent. To 
free the memory we use pci_free_consistent. Also for AGP there could be 
hooks just for it. So model 2 can be broken into 2 parts.

A) Memory mangement. We first allocate the memory needed. After drawing
   the image free the memory.

B) Draw the image. This occurs between the two events in A.


Now for model 1. A example would be the matrox fbdev driver for fast 
fonts. We allocate a region to store the font images before using them.
This buffer is pretty much permanent. Then we use indices to tell which
section of the allocated buffer to have the graphics engine use. 


So this is the model I have come up with. The tricky part I haven't 
figured out yet is working with irqs and how to relate fbcon with it. 
Comments?




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
