From: Holger Waechtler <holger@qanu.de>
Subject: Re: RE: [Dri-devel] Memory management of AGP and VRAM
Date: Sun, 09 May 2004 23:27:07 +0200
Sender: mesa3d-dev-admin@lists.sourceforge.net
Message-ID: <409EA22B.2040201@qanu.de>
References: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <mesa3d-dev-admin@lists.sourceforge.net>
In-Reply-To: <20040509164514.17651.qmail@web14922.mail.yahoo.com>
Errors-To: mesa3d-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=mesa3d-dev>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl wrote:
> Can you run grub or lilo on these machines?

The equivalent loader is called MILO for SPARC and Yaboot for PowerPC. 
The BIOS equivalent is called OpenFirmware and provides a helper API for 
mode setting and graphics card initialisation.

There are comments in the drivers which mark other than the default 
modes as TODO (e.g. 'these are somewhat sane defaults for Mac boards, we 
will need to find a good way of getting these from OpenFirmware'), I 
don't know whether they are rooted in missing docs or in technical 
troubles communicating with the OpenFirmware.

Holger


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
