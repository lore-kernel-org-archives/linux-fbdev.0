From: Andrew Lutomirski <luto@mit.edu>
Date: Wed, 25 May 2011 18:21:17 +0000
Subject: efifb not detected on Intel DQ67SW
Message-Id: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi-

For mostly masochistic reasons, I boot my DQ67SW box in UEFI mode.
efifb doesn't detect the anything, so I have no console until i915
loads.

Looking at the code, I'm a little confused how it's supposed to work.
AFAICT, unless there's a DMI match, then the driver will only load
ifthe boot code sets VIDEO_TYPE_EFI, but nothing sets that.

Should there be something that looks at
EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE to find the frame buffer?  (Does
that not work on Apple machines?)

--Andy
