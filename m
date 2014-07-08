From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 08 Jul 2014 09:27:09 +0000
Subject: Re: [PATCH v2] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <20140708092709.GI25880@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403818501-15547-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1403818501-15547-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, jasowang@redhat.com, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, olaf@aepfle.de, apw@canonical.com, plagnioj@jcrosoft.com, haiyangz@microsoft.com

Don't use likely/unlikely unless you have benchmark numbers to show that
it makes a speed up.

regards,
dan carpenter

