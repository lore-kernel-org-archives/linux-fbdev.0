From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 19 Aug 2012 17:28:59 +0000
Subject: [PATCH 0/6] HID: picoLCD additional fixes + CIR support
Message-Id: <20120819192859.74136bb0@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120730213656.0a9f6d30@neptune.home>
In-Reply-To: <20120730213656.0a9f6d30@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

Hi,

This series fixes some race conditions in picoLCD driver during remove()
and adds support for IR functionality.

Repeatedly binding/unbinding device at hid-picolcd driver level or at
usbhid level now works properly (except in rare occasions which trigger
a paging error in interrupt context (memcopy) and seem to come from
usbhid internals when usbhid gets interrupt between hid_hw_close() and
hid_hw_stop()).

CIR support is added using RC_CORE for the decoding and handling of
IR-event stream and works for a Sony and a JVC remote.

Bruno
