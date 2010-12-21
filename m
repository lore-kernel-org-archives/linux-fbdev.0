From: Prasad Joshi <prasadjoshi124@gmail.com>
Date: Tue, 21 Dec 2010 04:51:04 +0000
Subject: A query on frame buffers
Message-Id: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello All,

This is probably my first mail on this mailing list. I am working on a
university project on Nvidia or any GPU Pass-through in KVM. I have a
question related to framebuffer.

I was reading few documents on XEN VGA pass-through, the document says
the first step for pass-through is mapping the framebuffers in the VM
at specific address, specifically speaking 0xA0000 till 0xC0000.

I am not sure how the new framebuffer interface /dev/fbn works. Would
I need to map the host framebuffer at specific address in the Guest
VM?
Or should it be done differently with the help of /dev/fbn interface?

Please share your thoughts. Any pointers will be helpful. Please add
in CC as I am not subscribed to this mailing list.

Thanks and Regards,
Prasad
