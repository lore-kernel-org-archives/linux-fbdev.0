From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Who is stomping PCI config space?
Date: Sat, 05 Mar 2005 09:51:43 +1100
Message-ID: <1109976703.5610.314.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<16936.17069.428202.815866@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16936.17069.428202.815866@xf14.local>
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
To: Egbert Eich <eich@suse.de>
Cc: Xserver development <xorg@freedesktop.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> If you want to access these cards from inside your 
> kernel you could just check if they are enabled before 
> you do and enable them if they aren't. 
> This works as long as you can be sure nobody else will 
> access legacy resources from anywhere else - this may 
> be difficult if you have a machine with more than one 
> CPU, if you have more than one userland process that 
> may want to access the HW.
> You should make sure to restore the state before you 
> return.

Saving/restoring state doesn't help because of the SMP case.

> As a note on the side: 
> The Xserver doesn't 'stomp' over PCI config space any 
> more without telling the kernel: The code which does 
> direct PIO banging for config space access doesn't 
> get used any more unless the user explicitely *asks*
> for it. 
> The option to do so is well hidden from the user.
> This has been this way since X.Org 6.8.0 - I didn't 
> change this for 6.7.0 for lack of testing.
> 
> Egbert.
> _______________________________________________
> xorg mailing list
> xorg@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/xorg
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
