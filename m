From: Egbert Eich <eich@suse.de>
Subject: Re: Who is stomping PCI config space?
Date: Fri, 4 Mar 2005 12:12:45 +0100
Message-ID: <16936.17069.428202.815866@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: jonsmirl@gmail.com wrote on Thursday,
	3 March 2005 at 14:03:43 -0500 
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>

Jon Smirl writes:
 > 
 > Somebody is changing PCI command from 83 to 80 and disabling my
 > radeon's memory and iospace. Who is doing this? It has to be X since
 > it doesn't happen if I switch to VT6 or VT8.
 > 
 > Why is X mucking with a card it doesn't have a driver loaded for? 
 > Where is this happening in the X code?
 > 

Jon,

Yes, X is donig this as it is assuming that it is in 
charge of all the graphics hardware in the machine.

It has to make this assumption as it cannot be sure that 
the card has *no* legacy resources open. Without a driver 
loaded it has no way of knowing any differently.

It doesn't matter if these legacy ports are used on this 
card, it only matters these resources are used by another 
card for setup purposes. 

A lot of cards do have legacy ports open - even if nobody 
uses them and without the driver the Xserver cannot really 
do much about this.

At the time this was programmed this assumption was 
necessary for the fast majority of cards.
I claim it is still required for a large number of 
cards today as when the card has been POSTed the 
BIOS usually leaves the legacy ports open.

So far we have no central agent available to schedule
access to shared resources.

If you want to access these cards from inside your 
kernel you could just check if they are enabled before 
you do and enable them if they aren't. 
This works as long as you can be sure nobody else will 
access legacy resources from anywhere else - this may 
be difficult if you have a machine with more than one 
CPU, if you have more than one userland process that 
may want to access the HW.
You should make sure to restore the state before you 
return.

As a note on the side: 
The Xserver doesn't 'stomp' over PCI config space any 
more without telling the kernel: The code which does 
direct PIO banging for config space access doesn't 
get used any more unless the user explicitely *asks*
for it. 
The option to do so is well hidden from the user.
This has been this way since X.Org 6.8.0 - I didn't 
change this for 6.7.0 for lack of testing.

Egbert.
