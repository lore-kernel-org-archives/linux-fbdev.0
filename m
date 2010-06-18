From: Arvid Picciani <aep@exys.org>
Date: Fri, 18 Jun 2010 02:59:58 +0000
Subject: Relation of FBDev and DRM/KMS
Message-Id: <87sk4l82q9.fsf@exys.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi, 
I'm trying to crowbar some extra VMemory into fbdev devices to abuse
them in a similar fashion to what DRM does. I'm trying to avoid DRM for
various reasons, but it seems all of the new stuff _only_ goes in DRM.
Specifically, the intel/nvidia drivers seems to be only useful in 
combination with DRM. I need KMS for laziness, but that needs  DRM? 
No way to get kms without running DRM?
If i have to run DRM, is there any Documentation that explains the
relation to fbdev? Eyeballing around in the intel code tells me, the
framebuffer is actually a DRM gem thingy. Can i sort of blit other DRM
gems onto a framebuffer?
If i can avoid DRM, any idea how i could allocate small VMem areas from 
userspace  on demand? FB seems to have no api for that at all. 
All we have is a  single large VMem area to pixel manipulate.
Unless i totally missread that code. I am guessing, i could archive what
i want by adding some extra ioctls, but i dont see where, since the device 
is abstracted away from the drivers.
--
Arvid
