From: Egbert Eich <eich@suse.de>
Subject: Re: Who is stomping PCI config space?
Date: Fri, 4 Mar 2005 12:21:39 +0100
Message-ID: <16936.17603.208177.829376@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<42278AEC.4080706@dunaweb.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: zboszor@dunaweb.hu wrote on Thursday,
	3 March 2005 at 23:08:44 +0100 
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
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: Xserver development <xorg@freedesktop.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Zoltan Boszormenyi writes:
 > Hm. Someone other than a Linux-ruby user finally complaining. :-)
 > Try patching XFree or XOrg with the proper patch
 > 
 > http://www.ltn.lv/~aivils/files/080_pci_isolate_device_feature.diff
 > 
 > for XFree, or
 > 
 > http://www.ltn.lv/~aivils/files/Xorg-6.7.0-isolate_device.patch
 > 
 > for XOrg, it's applicable for XOrg-6.8.x, too.
 > 
 > Then add
 >           Option         "SingleCard" "on"
 > to your Section "ServerLayout".
 > 

This patch adds another wart to the resource broker ;-)
But it may actually help the people who need this advanced 
feature and know what they are doing.
I have thought about putting something like this in but was
discouraged when I saw users trying out every single option
and then complaining that it didn't work.

I would rather go with something 'automatic'. This would be
a resource broker outside of X.

Still I'm inclined to adding something like this to the code
however I'm reluctant to document it so well ;-)

Cheers,
	Egbert.
