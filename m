From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 15 Mar 2018 14:17:49 +0000
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Message-Id: <20180315141749.GA27100@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <6c9d075c-d7a8-72a5-9b2d-af1feaa06c6c@suse.de>
 <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
In-Reply-To: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Networking <netdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-usb@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>, David Howells <dhowells@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-rtc@vger.kernel.org

On Thu, Mar 15, 2018 at 11:42:25AM +0100, Arnd Bergmann wrote:
> Is anyone producing a chip that includes enough of the Privileged ISA spec
> to have things like system calls, but not the MMU parts?

Various SiFive SOCs seem to support M and U mode, but no S mode or
iommu.  That should be enough for nommu Linux running in M mode if
someone cares enough to actually port it.
