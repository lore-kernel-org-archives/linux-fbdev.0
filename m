From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 30 Apr 2011 14:18:03 +0000
Subject: viafb misc patches
Message-Id: <1304173086-3434-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This patch series contains various patches. One is a significant 
performance improvement for applications which use the framebuffer. 
Another one tries harder to make the framebuffer work by reducing 
the address space required for remapping, but as VIAs X server we 
still need a lot of parameters to be set correct to get a usable 
display. The last one is a little dead code removal.


Best regards,

Florian Tobias Schandinat

