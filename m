From: David Vrabel <david.vrabel@citrix.com>
Date: Thu, 18 Oct 2012 10:02:07 +0000
Subject: [PATCH 0/5] drivers: xen frontend devices should handle missed backend CLOSING
Message-Id: <507FD39F.4060601@citrix.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Vrabel <david.vrabel@citrix.com>

Subsystem maintainers, you can either pick up the relevant driver patch
or ack it to go via Konrad's Xen tree.

The series makes all the Xen frontend drivers handle the backend
transitioning to CLOSED without the frontend having previously seen
the backend in the CLOSING state.

Backends shouldn't do this but some do.  e.g., if the host is
XenServer and the toolstack decides to do a forced shutdown of a VBD,
then the blkfront may miss the CLOSING transition and the /dev/xvdX
device will not be destroyed which prevents it being reused.

I have seen systems that ended up in this state but it's not clear if
this was the actual cause.  However, I think in general it's a good
thing to thing to improve the handling of unexpected state
transitions.

David
