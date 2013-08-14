From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Aug 2013 18:47:49 +0000
Subject: Changing which device has VTs?
Message-Id: <CALCETrX5_CAREEPSWkwE6+bY+w+c_qJcYBVM7Nx16_URZ9Gn5A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I have a box with a real graphics card (radeon) and an onboard
graphics card (mgag200).  I want to use the radeon and ignore the
mgag200.  For reasons of extreme firmware suckage, I have two choices:

1. Leave both devices enabled in BIOS and set the mgag200 device
primary.  This causes efifb and later mgag200 to both point at the
mgag200.  All of my text consoles end up on the mgag200.  This is
unfortunate, especially because if, even if I set xorg to ignore the
mgag200 device, hitting ctrl-alt-f2 causes X to suspend itself and my
text console to show up on a device with no monitor attached.

2. Set the radeon device as primary in BIOS.  System doesn't boot.

I'd like to leave mgag200 primary but tell Linux to put all the text
consoles on the radeon device once it shows up.  I could compile out
both efifb and mgag200, but that seems like a waste.  Is there any way
to do this with a command-line parameter?  I tried fbcon=map:1, and I
get no fbcon at all.

-- 
Andy Lutomirski
AMA Capital Management, LLC
