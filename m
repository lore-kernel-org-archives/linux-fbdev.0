From: Guy Yasko <gyasko@gmail.com>
Subject: Re: How to disable 'rivafb_pan_display START' at boot ?
Date: Sat, 07 Jan 2006 23:48:12 -0500
Message-ID: <87wthbtjeb.fsf@oedipa.disorg>
References: <43C0279A.7060708@paradise.net.nz>
Mime-Version: 1.0
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
In-Reply-To: <43C0279A.7060708@paradise.net.nz> (Adam Felix Bogacki's message
	of "Sun, 08 Jan 2006 09:42:02 +1300")
Resent-Message-ID: <QZD4f.A.RBB.WmJwDB@murphy>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Felix Bogacki <afb@paradise.net.nz>
Cc: ajoshi@unixbox.com, linux-fbdev-devel@lists.sourceforge.net, linux-nvidia@lists.surfsouth.com, debian-powerpc@lists.debian.org

On 2006.1.7, Adam Felix Bogacki stated:


> I have been trying various boot parameters to disable 'rivafb' without
> success, including
> 
> BOOT_DEBUG=3
> debian/installer/framebuffer=false
> video=vga16:off
> console=ttys0
> console=tty1

Isn't it video=ofonly for the openfirmware framebuffer and
video=nvidiafb to specify the newer nvidia driver?  In any case,
compiling a kernel without rivafb would seem to be a good idea.


-- 
Guy Yasko -- gyasko@sympatico.ca
