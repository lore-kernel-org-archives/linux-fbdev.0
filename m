From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 18:29:33 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051820470.27760-100000@phoenix.infradead.org>
References: <1046852721.1228.13.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qdeh-00051j-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 10:30:16 -0800
In-Reply-To: <1046852721.1228.13.camel@localhost.localdomain>
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


> 1. Text mode support?

We should remove it. Fbcon is to much bloat for text mode hardware. The 
only driver that does support a text mode matrox. Sparcs do not support 
text mode except for promcon. The issue was was a misunderstanding on teh 
flexiablity of imageblit. The name image blit stirs up this idea of the 
function has to be a place a image in buffer and send it on it way. This 
is not the case. Take a look at cg6.c. Fancy tricks are still possible. 
 
> 2. console resizing using fbset (besides stty)?

Fbcon needs alot of work on this. In theory it shoudl be smart enought to 
handle the small details. 

> 3. support for unloading of fbcon if modular?

It can be done. I used fbcon modular with MDA text mode. I can test the 
fbcon driver. The issue is if we have more than one vga card whcih vga to 
graphics card mapping. 
 
> 4. driver specified placement of buffers - for putcs method?

Working on this. I think it is possible to merge the tileblit stuff with 
the new buffer code.

> 5. flexible logo placement/overlayed logo?

Not so important. More important is fixing fbcon to work with the logo 
code. You can't compile it right now.

> 6. generic console display rotation?

Not so important right now. I removed the poll stuff. using signals is 
better.
 
> 7. Anything else?

The cursor code needs cleanup and documentation. 
 
> 8. feature freeze deadline?

We are very near this. IMO we have two things to work on. The buffer stuff 
and cleaning up the cursor code.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
