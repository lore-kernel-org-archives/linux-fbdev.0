From: Otto Solares <solca@guug.org>
Subject: Re: I want to use fb device for my 3D game. Can it do what I need?
Date: Fri, 9 Jan 2004 16:34:21 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040109223421.GC20620@guug.org>
References: <200401092200.10820.andrew@walrond.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af5CU-0005Xt-It
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 14:33:54 -0800
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Af5CU-0008I8-7v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 14:33:54 -0800
Content-Disposition: inline
In-Reply-To: <200401092200.10820.andrew@walrond.org>
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
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 09, 2004 at 10:00:10PM +0000, Andrew Walrond wrote:
> Hello list!
> 
> I have developed a software library for rendering 3D scenes.

Hmm.. cool! how you construct the 3D scenes?

> It would be very cool if I could use the fb device so that X needn't be 
> running, freeing considerable resources for the application
> Note that it is a _software_ renderer, I don't need access to 3D hardware 
> acceleration, just a means of copying/bliting frames to the screen as fast as 
> possible, and a double buffering facility
> 
> So what I need is an api allowing me to
> 
> - Set the screen resolution/colour depth. (16bit colour depth or better is 
> required)

Already part of fbdev.

> - Allocate front and back buffers
> 
> - Copy scene to back buffer
>
> - Swap buffers synced with vertical refresh
>
> Does fbdev have the facilities I need?

You would probably want to look at SDL's fbdev backend.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
