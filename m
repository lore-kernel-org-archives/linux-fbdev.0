From: Aishwarya Pant <aishpant@gmail.com>
Date: Tue, 02 Jan 2018 08:54:45 +0000
Subject: Documentation: OMAPDSS: move sysfs documentation to ABI
Message-Id: <20180102085436.GA32637@mordor.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>

Hi

In Documentation/arm/OMAP/DSS, there is a description of the DSS and FB sysfs
interfaces which could be moved to Documentation/ABI.

Would such a change be useful? I can see that the sysfs interface is still in
testing.

The ABI documentation format looks like the following:

What:          (the full sysfs path of the attribute)
Date:          (date of creation)
KernelVersion: (kernel version it first showed up in)
Contact:       (primary contact)
Description:   (long description on usage)

I am doing this in an exercise to move sysfs ABI interfaces (which are
documented) to their right place i.e. in Documentation/ABI along with the rest.

Aishwarya
