From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 19:27:15 +0000
Subject: Re: [PATCH v1 05/47] pci: add pci_iomap_wc() variants
Message-Id: <CAB=NE6UVSQUu241_Onc7Ez-okanMnExcwtAy-KYKhSyH6TxNzQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-6-git-send-email-mcgrof@do-not-panic.com>
 <CAErSpo5LfgTM879jmt58yLrXD6e7spsaX1wNDcc2ppU9JrMXOg@mail.gmail.com> <20150421211557-mutt-send-email-mst@redhat.com>
In-Reply-To: <20150421211557-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Bader <stefan.bader@canonical.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, David Vrabel <david.vrabel@citrix.com>, Toshi Kani <toshi.kani@hp.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, xen-devel <xen-devel@lists.xensource.com>

On Tue, Apr 21, 2015 at 12:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> To summarise, driver needs to know what it's doing,
> we can't set WC in the pci core automatically.

Thanks, I'll document this and proceed with device driver helpers to
aid with this.

 Luis
