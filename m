From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: matrox ported to new framework?
Date: Sat, 24 May 2003 10:48:46 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030524174846.49900.qmail@web14913.mail.yahoo.com>
References: <20030524195429.A2238@armor.free.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Jd8Q-0002zj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 May 2003 10:48:46 -0700
In-Reply-To: <20030524195429.A2238@armor.free.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Souchu <nsouch@free.fr>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Nicolas Souchu <nsouch@free.fr> wrote:
> Also, I have a AIW (Rage128) 32MB that is neither
> supported by
> 2.4.9 nor by 2.5.69. Any hint?
> 
Not all of the Rage128 PCI ids are in the id table.
Just try adding all of the ones from the kernel
include file. I have yet to find one that didn't work.
I believe the ID for the AGP AIW is missing from the
driver's table.

I have the PCI AIW 1002:5044. Something is strange
with the driver on 2.5.69. It will work if compiled
in, but it won't initialize with a modprobe. There is
probably something wrong in the driver's PCID table
which needs to be updated for 2.5.69.



=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
