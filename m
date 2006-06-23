From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PATCH] Geode patches for 2.6.17
Date: Fri, 23 Jun 2006 19:41:09 +0100
Message-ID: <1151088069.4549.72.camel@localhost.localdomain>
References: <20060623170058.GA12819@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751892AbWFWSZn@vger.kernel.org>
In-Reply-To: <20060623170058.GA12819@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

Ar Gwe, 2006-06-23 am 11:00 -0600, ysgrifennodd Jordan Crouse:
>       Add a configuration option to avoid automatically probing VGA

Can you not do this automatically using the DMI data or PCI subvendor
id ?
