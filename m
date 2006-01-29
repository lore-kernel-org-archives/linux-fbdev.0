From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: Howto do i2c communication of videocard
	and monitor ??
Date: Sun, 29 Jan 2006 21:33:51 +0100
Message-ID: <1138566831.25782.12.camel@localhost>
References: <e3e24c6a0601291149y59f17082ja8b0dbdcdaf7e004@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3JEP-0006O8-Ki
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 12:33:05 -0800
Received: from 26.mail-out.ovh.net ([213.186.42.179])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1F3JEO-0000Rk-3K
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 29 Jan 2006 12:33:05 -0800
In-Reply-To: <e3e24c6a0601291149y59f17082ja8b0dbdcdaf7e004@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Vishal Soni <vishal.linux@gmail.com>

Hi Vishal,

On Mon, 2006-01-30 at 01:19 +0530, Vishal Soni wrote:
> Hi,
> 
>   I am trying to communicate to the monitor eeprom to get the
> monitor capabilities and for that i need to have SDA/SCL bit positions
> in the control word register of the video card (to read and wrtie data
> using i2c protocol).

You would perhaps be interested in ddccontrol
(http://ddccontrol.sourceforge.net): it controls monitor parameters
(brightness, contrast, etc.) using DDC/CI protocol on the I2C busses of
the graphics card. Maybe you could use this code as a basis.

> Different video card vendors have different offsets for the control
> word register and different bit positions for SDA/SCL.
> 
> I tried to use linux exported Symbol "get_EDID_from_firmware" and then
> using kgdb to debug the kernel module (that i wrote) to get the same
> but failed to find the way to get the above.

I don't think this kind of application should be in the kernel,
ddccontrol works in user-space, either by using /dev/i2c-* devices
provided by most kernel framebuffer drivers, or by writing directly to
PCI memory, when there is no support in the kernel, or when the
framebuffer driver conflicts with proprietary 3D-accelerated drivers
(ATI, nVidia).

I hope this helps.

Best regards,

Nicolas

> I do have the offset of the control word register and Masking Value of
> Intel and Matrox card but i would like NOT to hardcode the masking
> value and the offset in my code. This will lead me to modify  my code
> for the different cards.
> 
> Is there any way to get the control word register's address (and then
> SDA/SCL bit position) on the linux operating system ?
> 
> FYI : Masking Value that i am referring to is the value that has to be
> ANDed to the DATA(bit - 0/1) before writing it to Control word
> register so that the right bit can be written on to the SDA/SCL lines.
> 
> or to sum up ::
> How to get SDA/SCL bit position in the control word register of the video card?
> 
> Any pointers to this or your guidance would be highly appreciated.
> 
> Thank you for your time.
> regards,
> Vishal.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
